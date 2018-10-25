# TaskTracker

App to Task Tracks


Resource Design

Users: represents a user with a Task Tracker Account who can login/out, create tasks, complete tasks, assign users to tasks, and log work on the tasks they are assigned to
- email: string (unique)
  - a unique email address that identifies this user

Tasks: represents a task with a title, description, indicator of how much time has been spent on it, indicator of whether or not it is complete and a user who it is assigned to.
- Title: String
  - the title of the task

- Description: text
  - a description of the task

- Time_spent: integer
  - the time logged by the person assigned to the task

- Complete: Boolean
  - whether or not the task is complete

- user_id: References User by id
  - references a user who is assigned to this task



Login/Registration Design

- The main page is a login/registration page

If a user has already registered an account, they can login with the email they registered

If a user wishes to register a new account, they can input an email address.
The registration input field validates for:
- Email required
- Email in the correct format
- Email is unique (account has not been registered with that email yet)



Task List Design

"My Tasks" Table
- Shows only the tasks that are assigned to the user who is currently logged in
- The only place a user can log time to a task is through the "Log time" link on the My Tasks table (means that only users who are assigned to a task can log time for that task)

"All Tasks" Table
- Shows all tasks that are currently created in the task tracker
- Edit link allows for changing the user assigned to the task
  - use a drop down for this to ensure that invalid users are not assigned
- Edit link allows for marking a task complete because all users are allowed to mark any task complete
- Edit link allows for editing title/description


Manager Design
- Add a manager_id to the User resource which references the user resource
- Users are forced to select a manager, but can make themselves their own manager if they do not report to anyone
- The table of "underlings" shows a users' name, email, and links to a task report which shows the users tasks and their status


Time Logging
- Adding timeblocks, post to ajax timeblocks resource
- Editing/deleting timeblocks: add a callback for the button and delete/edit with a delete/put request then reload the table accordingly to reflect the change
- For time tracking
    - When start is pressed then store the start time in a JS variable, hide the start button and show the stop button
    - When stop is clicked, post to ajax timeblocks resource with the saved start time and the new end time then reload the table to show the new timeblock



