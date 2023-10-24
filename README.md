# Swift-constrains-programatically
Example of design app without using storyboard in iOS swift.

To build a sample application which mainly provides input form, field data checking and submit action. Please refer to the UI and coding with best practice.
Requirement
• Support iOS 13+
• Architecture: MVVM / VIPER with UIKit
• Code in testable, readable and maintainable manner
• Cover with unit test
AC 1
Given the user has landed on the input page. The user can see :
• Title: Join us
• Input field with label:
• Name
• Phone
• Gender
• Need Uniform
• Uniform Size (Default hidden)
• CTA button: Submit (Default disable)
AC 2
Given the user has clicked the `Name` field, the user is available to input. It will check the input field validation :
• Only accept 5-35 characters
• alphabet only
Otherwise, inline errors will be shown.
AC 3
Given the user has clicked the `Phone` field, the user is available to input. It will check the input field validation :
• Correct phone number format starting with `+`, no space
• Number only except `+` sign Otherwise, inline errors will be shown.
AC 4
Given the user has landed on the input page.
The user is available to select options from the `Gender` segment.
• Default value is nil.
AC 5
Given the user has landed on the input page.
The user is available to select options from the `Need Uniform` segment.
• When the toggle is turned ON, hidden field `Uniform Size` will be displayed in form
• Default value is OFF
AC 6
Given the user has selected `Need Uniform` is ON on the input page. The user is able to see the `Uniform Size` field in form.
• Click to selection list for size options (Once selected, pass back option to field in input form)
• When the toggle is turned ON, hidden field `Uniform Size` will be displayed in form
• Default value is `Not set`
AC 7
Given the user has landed on the input page. The user is able to click `Submit` button when :
• All enabled field is filled
• No error
Otherwise, `Submit` button is kept disabled.
