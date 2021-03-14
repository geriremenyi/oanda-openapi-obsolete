# OpenAPI Specification for OANDA's REST API v20

This repository is a more organized version of the [generated OANDA v20 REST API's OpenAPI definition](https://github.com/oanda/v20-openapi). The definition is rewritten to leverage OpenAPI's newest (3.x.x) syntax. Also the definitions are separated into different files and redundancy is removed.

## Getting started

### Prerequisites

- [Node](https://nodejs.org/en/) to bundle, test etc.
- [Yarn](https://classic.yarnpkg.com/en/docs/install) for package dependencies.
- [Java](https://classic.yarnpkg.com/en/docs/install) (optional) to generate code.
- [Visual Studio Code](https://code.visualstudio.com/) (optional) as the IDE.

### Local setup

1. Clone this repo
```bash
# HTTPS
https://github.com/geriremenyi/oanda-openapi.git
# SSH
git@github.com:geriremenyi/oanda-openapi.git
```

2. Navigate to the root of the project and install all dependencies
```bash
yarn install
```

### Bundle

To bundle the seperate `.yaml` files into one big openapi definition run the following command
```bash
npm run bundle
```

### Validate

To validate that the definition complies with the OpenApi 3 standards run the following commands:
```bash
# Validates the separate yamls
npm run validate:original
# Validates the bundled yaml
npm run validate:bundled
```

### Generate code

To generate code you will need JVM because the code generator package is just a wrapper around the [official code generator](https://github.com/OpenAPITools/openapi-generator) written in Java.

To generate C# (.NET core) client run the following command:
```bash
npm run generate:csharp-netcore
```

You can add more code generators via defining it in the [config](./config) folder and creating a new run command in the [package.json](./package.json).

## Demo

The definition is published using SwaggerUI hosted on this repo's github page:

[https://geriremenyi.github.io/oanda-openapi/](https://geriremenyi.github.io/oanda-openapi/)

## Generated client repos

There is a [continuous integration](.github/workflows/continuous_integration.yaml) job setup which [runs on every pull request](https://github.com/geriremenyi/oanda-dotnet-client/actions?query=workflow%3A%22Continuous+Integration%22). This makes sure that the definition is syntactically correct.

There is also a [continuous deployment](.github/workflows/continuous_deployment.yaml) job setup which [runs on every merge to master](https://github.com/geriremenyi/oanda-dotnet-client/actions?query=workflow%3A%22Continuous+Deployment%22). This generates the client codes and pushes them to the corresponding GitHub repos.

### C# (.NET core)

The generated C# code is pushed to [nuget.org](https://www.nuget.org/) on every push to the target client repository.

Repository: https://github.com/geriremenyi/oanda-dotnet-client

Nuget package: https://www.nuget.org/packages/GeriRemenyi.Oanda.V20.Client/

## Contributing

Pull requests and any kind of contribution are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
