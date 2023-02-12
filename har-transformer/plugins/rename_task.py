from transformer.plugins import plugin, Contract
from transformer.task import Task2

#
# har-transformer plugin to use the comment field of a HAR entry when naming the to be created Locust Task
#
@plugin(Contract.OnTask)
def plugin(task: Task2) -> Task2:
    task_request = task.request
    request_har_entry = task_request.har_entry

    comment = request_har_entry["comment"]

    task_request.name = comment

    return task
