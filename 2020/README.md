# AoC 2020

## Getting started

### Requirements

- Go version 1.15

_Note_: A docker setup is also available

### Run the solution for a specific day

```shell
bin/start 01 # Runs day 01
bin/start 24 # Runs day 24
```

### Benchmark a specific day

The `benchmark` command runs the solution 1000 times to get an average execution time.

```shell
bin/benchmark 01 # Benchmarks day 01
bin/benchmark 24 # Benchmarks day 24
```

### Run tests

```shell
bin/test # Runs all go test files
```

### Run linter

```shell
bin/lint # Prints lint errors to fix
```

### Run code formatter

```shell
bin/format # Formats and save all go files
```

### Run a day with docker

```shell
bin/docker-start # Runs day 01 by default
```

Use the `-b` flag to build the container when you first run it, or when you make an update:

```shell
bin/docker-start -b
```

Choose the day you want to run with the `-d` flag:

```shell
bin/docker-start -d 8 # Runs day 08
```

