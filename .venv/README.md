# Python Virtual Environment

## First Time Setup

These steps for the first time setup of the virtual environment:

### Create Virtual Environment in the current directory

```shell
python3.10 -m venv .
```

### Activate the Virtual Environment

In the current shell:

```shell
source ./bin/activate
```

### Install packages in the Virtual Environment

1. pip

```shell
python -m pip install --upgrade pip
```

2. har-transformer

Source: <https://pypi.org/project/har-transformer>

```shell
python -m pip install har-transformer 
```

3. locust

Source: <https://pypi.org/project/locust>

```shell
python -m pip install locust 
```

### Deactivate the Virtual Environment

In the current shell:

```shell
deactivate
```

## HTTP Proxy Settings

Optional step.

The `pip` package installer downloads packages from PyPI. You may need to use proxy for internet access.

Setting the standard proxy environment-variables:

```shell
export http_proxy=http://[user:passwd@]<host>:<port>
export https_proxy=https://[user:passwd@]<host>:<port>
```

## Requirements File

Optional step.

Packages can be installed automatically also from an earlier created _Requirements File_.

### Create

Snapshot of the currently installed packages:

```shell
python -m pip freeze > requirements.txt
```

### Install

Install packages from _Requirements File_.

```shell
python -m pip install -r requirements.txt
```
