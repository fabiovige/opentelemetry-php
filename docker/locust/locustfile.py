from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 2.5)

    @task(1)
    def index(self):
        self.client.get("http://localhost:8989/api/hello")
