# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskTracker.Repo
alias TaskTracker.Users.User

Repo.insert!(%User{name: "Alice Smith", email: "alice@example.com"})
Repo.insert!(%User{name: "Bob Johnson", email: "bob@example.com", manager_id: 1})
Repo.insert!(%User{name: "Raquel Levy", email: "raquel@example.com", manager_id: 2})
Repo.insert!(%User{name: "Joe Annis", email: "joe@example.com", manager_id: 3})
Repo.insert!(%User{name: "Tina Norani", email: "tina@example.com", manager_id: 3})
Repo.insert!(%User{name: "Catu Berrreta", email: "catu@example.com", manager_id: 3})