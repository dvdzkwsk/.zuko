{
  "Console log": {
    "prefix": "log",
    "body": [
      "console.log($1)"
    ]
  },
  "Console group": {
    "prefix": "group",
    "body": [
      "console.group('${1}')",
      "console.log(${2})",
      "console.groupEnd()"
    ]
  },
  "Console warn": {
    "prefix": "warn",
    "body": [
      "console.warn('$1')",
      "$2"
    ]
  },
  "Describe": {
    "prefix": "des",
    "body": [
      "describe('$1', () => {",
      "  $2",
      "})"
    ]
  },
  // ======================================================
  // React
  // ======================================================
  "Create React Stateless Component": {
    "prefix": "rc",
    "body": [
      "const $1 = () => (",
      "  $2",
      ")"
    ]
  },

  "Create React Component Class": {
    "prefix": "rclass",
    "body": [
      "class $1 extends React.Component {",
      "  render() {",
      "    $2",
      "  }",
      "}"
    ]
  },

  "componentWillMount": {
    "prefix": "cwm",
    "body": [
      "componentWillMount() {",
      "  ${1}",
      "}"
    ]
  },

  "componentDidMount": {
    "prefix": "cdm",
    "body": [
      "componentDidMount() {",
      "  ${1}",
      "}"
    ]
  },

  "componentWillReceiveProps": {
    "prefix": "cwr",
    "body": [
      "componentWillReceiveProps(nextProps) {",
      "  ${1}",
      "}"
    ]
  },

  // No componentWillUpdate or componentWillUpdate since I hardly them
  // and prefer smaller shorthands for other methods.

  "componentWillUnmount": {
    "prefix": "cwun",
    "body": [
      "componentWillUnmount() {",
      "  ${1}",
      "}"
    ]
  },

  // ======================================================
  // Testing (Mocha)
  // ======================================================
  "It": {
    "prefix": "it",
    "body": [
      "it('$1', () => {",
      "  $2",
      "})"
    ]
  }
}
