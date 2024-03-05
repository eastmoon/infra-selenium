# Import library
from selenium import webdriver
from selenium.webdriver.common.by import By
from time import sleep

# Start the session
options = webdriver.ChromeOptions()
options.add_argument('--ignore-ssl-errors=yes')
options.add_argument('--ignore-certificate-errors')
options.add_argument('--disable-gpu')
options.add_argument("--start-maximized")
options.set_capability("se:name", "My simple test")
options.set_capability("se:sampleMetadata", "Sample metadata value")
driver = webdriver.Remote(
    command_executor='http://chrome:4444',
    options=options
)

# Take action on browser
driver.get("https://www.selenium.dev/selenium/web/web-form.html")

# Request browser information
title = driver.title

# Establish Waiting Strategy
driver.implicitly_wait(0.5)

# Find an element
text_box = driver.find_element(by=By.NAME, value="my-text")
submit_button = driver.find_element(by=By.CSS_SELECTOR, value="button")

# Take action on element
text_box.send_keys("Selenium")
submit_button.click()

# Request element information
message = driver.find_element(by=By.ID, value="message")
text = message.text

# Python time sleep Waiting Strategy
sleep(3)

# End the session
driver.quit()

# Assert information
assert title == "Web form"
assert text == "Received!"

# Print information
print(f"{title}: {text}")
