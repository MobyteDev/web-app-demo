# Web App Demo

This is the demo of a web application written in Flutter. The application is a chat bot.

The main page contains a header, body and footer.

The **header** contains a text field in which the user can search for a company. 
![Demo Header](/demo_pics/demo_header.png)

Then a message is generated in the chat bot and a request is sent to the server. Then the user receives information about the company as a response.
![Demo Header](/demo_pics/demo_first_request.png)

The **footer** contains buttons that execute requests when clicked. If the query is multi-level, the next levels of the query appear with corresponding buttons for the next queries. At the last level, the request generates a message in the chat bot and requests information from the server, which comes in **markdown** format and is processed into a suitable form.
![Demo Header](/demo_pics/demo_first_level.png)

![Demo Header](/demo_pics/demo_second_level.png)

![Demo Header](/demo_pics/demo_third_level.png)


The web application also has an **adaptive layout** for different screen sizes.

The full demo:
![Demo Header](flutter_web_app_demo.gif)
