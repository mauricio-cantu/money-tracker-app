alias MoneyTracker.Repo
alias MoneyTracker.Web.Account

Repo.insert!(%Account{title: "Wallet", balance: 150})
Repo.insert!(%Account{title: "Bank 1", balance: 200})
Repo.insert!(%Account{title: "Bank 2", balance: 300})
