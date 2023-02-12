
# Generated locustfiles and test run configurations

## Decorate Requests with Client Certificates

Add parameter 
`cert=('cert/auxtest.pem')`
 to 
`self.client.get(...)`
calls

## Limit the number of test iterations

By adding a closing task to the task sequence

```python
import logging
import time
```
...
```python
@seq_task(999)
def iteration_limit(self):
    time.sleep(1)
    logging.info('Reached iteration limit 1, stop')
    self.user.environment.runner.quit()
```

## Tag tasks

To limit the test to only execute tasks that are tagged with any of the tags provided

```python
from locust import tag
```
...
```python
@tag('REST_GET_NGD_TEST')
@task(1)
class REST_GET_NGD_TEST_788006179(TaskSequence):
```
