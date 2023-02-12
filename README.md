
# GRPS interface tests in Locust load testing framework generated from HAR file exports

## Convert HAR file to Locust test

```shell
har_to_locust.sh <TEST_CASE>
```

`<TEST_CASE>` is a reference to a HAR file in the `har` directory.

File path should look like: `har/<TEST_CASE>/<TEST_CASE>.har`.

Locust scripts are generated into the `locust` directory.

## Locust test runner

```shell
locust_test_runner.sh <TEST_CASE>
```
