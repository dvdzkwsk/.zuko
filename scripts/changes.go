package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"regexp"
	"strings"
	"sync"

	"github.com/blang/semver"
)

type Lookup struct {
	Repo         string
	StartVersion string
	EndVersion   string
	Changesets   []Changeset
}

var lookups = []*Lookup{
	&Lookup{"https://raw.githubusercontent.com/microsoft/fluent-ui-react/master/CHANGELOG.md", "0.39.0", "0.40.1", []Changeset{}},
	&Lookup{"https://raw.githubusercontent.com/mobxjs/mobx/master/CHANGELOG.md", "5.14.0", "5.14.2", []Changeset{}},
}

func main() {
	var wg sync.WaitGroup
	for _, p := range lookups {
		wg.Add(1)
		go func(p *Lookup) {
			defer wg.Done()
			p.Changesets = lookupChangelog(*p)
		}(p)
	}
	wg.Wait()
	for _, lookup := range lookups {
		printChangesets(*lookup)
	}
}

func printChangesets(lookup Lookup) {
	fmt.Printf("%s\n", lookup.Repo)
	for _, cs := range lookup.Changesets {
		fmt.Printf("  [%s]\n", cs.Version)
		for _, c := range cs.Changes {
			fmt.Printf("    %s\n", c)
		}
	}
}

func lookupChangelog(lookup Lookup) []Changeset {
	resp, err := http.Get(lookup.Repo)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}
	changesets, err := getChangesBetween(body, lookup.StartVersion, lookup.EndVersion)
	if err != nil {
		log.Fatal(err)
	}
	return changesets
}

// Changeset describes changes to a package at a particular version
type Changeset struct {
	Version string
	Changes []string
}

// Append adds a change to a changeset
func (c *Changeset) Append(change string) {
	c.Changes = append(c.Changes, change)
}

// String stringifies a changeset
func (c *Changeset) String() string {
	return strings.Join(c.Changes[:], "\n")
}

func getChangesBetween(bytes []byte, startVersion string, endVersion string) ([]Changeset, error) {
	var changeset *Changeset
	var version semver.Version

	changesets := make([]Changeset, 0)
	checkRange, err := semver.ParseRange(fmt.Sprintf(">=%s <=%s", startVersion, endVersion))

	if err != nil {
		return changesets, fmt.Errorf("failed to create semver range >=%s <=%s: %s", startVersion, endVersion, err)
	}

	scanner := bufio.NewScanner(strings.NewReader(string(bytes)))
	for scanner.Scan() {
		line := scanner.Text()

		// ignore empty lines
		if len(strings.TrimSpace(line)) == 0 {
			continue
		}

		// if this line is the start of a new version block, create a new changeset
		nextVersion, found := parseVersion(line)
		if found {
			// some changelogs repeat the current version number; ignore those.
			if version.Equals(nextVersion) {
				continue
			}

			version = nextVersion
			if changeset != nil {
				changesets = append(changesets, *changeset)
			}

			// if the version isn't in range, ignore all subsequent lines until
			// a wanted version is found. Store the previous changeset if it exists.
			// If it's a wanted version, create a new chaneset.
			if !checkRange(version) {
				changeset = nil
			} else {
				changeset = &Changeset{version.String(), make([]string, 1)}
				continue
			}
		}
		if changeset != nil {
			changeset.Append(line)
		}
	}
	if changeset != nil {
		changesets = append(changesets, *changeset)
	}
	return changesets, nil
}

// parseVersion parses a version number from a string if it follows one of
// these conventions:
//
// <!-------- [version] ------------>
// # [version]
// ## [version]
//
// TODO: a string might contain multiple versions
// TODO: more resilient version parsing; also: ignore links to other versions
func parseVersion(str string) (semver.Version, bool) {
	re := regexp.MustCompile(`^(?:#+\s*|<!-.*)(\d+\.\d+\.\d+)`)
	matches := re.FindStringSubmatch(str)
	if len(matches) == 0 {
		return semver.Version{}, false
	}
	version, err := semver.Parse(matches[1])
	if err != nil {
		return semver.Version{}, false
	}
	return version, true
}
