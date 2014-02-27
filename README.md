Kuality-Coeus: Test Automation
==============================

Overview
--------

This project consists of Cucumber-based test scripts for validating Kuali Coeus functionality

Requirements
------------

* Ruby 1.9.3 or newer
* TestFactory 0.4.3
* Watir-webdriver 0.6.4

In order for the scripts to actually run successfully, you will need to add a `config.yml` file in your /features/support directory.

The contents of that file should be as follows:

```ruby
:basic:
  :url: https://<your.kuali.test.server.address.goes.here>/kc-dev/
  :browser: :ff # ... or :chrome, :safari, etc.
```

Contribute to the Project
-------------------------

1. Fork the repository
2. Study the TestFactory design pattern
3. Make a new branch to contain your work
4. Write a feature and associated scenarios, along with the underlying support code
5. Squash your commits
6. Send a pull request, with a concise description of your changes

Copyright 2014 The Kuali Foundation
-----------------------------------

	Licensed under the Educational Community License, Version 2.0 (the "License");
	you may	not use this file except in compliance with the License.
	You may obtain a copy of the License at

    http://www.osedu.org/licenses/ECL-2.0

	Unless required by applicable law or agreed to in writing,
	software distributed under the License is distributed on an "AS IS"
	BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
	or implied. See the License for the specific language governing
	permissions and limitations under the License.