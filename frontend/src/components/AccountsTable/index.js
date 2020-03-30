import React from 'react'
import './styles.css'

export default function AccountsTable(props) {
  if (!props.accounts.length) {
    return <p className="no-accounts">You haven't added any accounts yet.</p>
  } else {
    return (
      <section className="list-accounts">
        <table className="table table-accounts ">
          <thead>
            <tr>
              <td>Title</td>
              <td>Balance</td>
            </tr>
          </thead>
          <tbody>
            {props.accounts.map(el => (
              <tr key={el.id}>
                <td>{el.title}</td>
                <td>
                  {Intl.NumberFormat('pt-BR', {
                    style: 'currency',
                    currency: 'BRL'
                  }).format(el.balance)}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    )
  }
}
