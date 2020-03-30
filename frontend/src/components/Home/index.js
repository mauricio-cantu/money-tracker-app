import React, { useState, useEffect } from 'react'
import './styles.css'
import { Button, Modal, ModalBody, ModalHeader } from 'shards-react'
import AccountsTable from '../AccountsTable'
import api from '../../services/api'
import Swal from 'sweetalert2'
import AccountForm from '../Forms/AccountForm'
import TransactionForm from '../Forms/TransactionForm'
import DepositForm from '../Forms/DepositForm'

export default function Home() {
  // accounts list state
  const [accounts, setAccounts] = useState([])

  // modals states
  const [openModalAccount, setOpenModalAccount] = useState(false)
  const [openModalDeposit, setOpenModalDeposit] = useState(false)
  const [openModalTransaction, setOpenModalTransaction] = useState(false)

  // default configs for alerts
  const swal = Swal.mixin({
    timer: 3000,
    timerProgressBar: true,
    showConfirmButton: false,
    toast: true,
    position: 'top-end'
  })

  // gets account list from server
  async function fetchData() {
    await api
      .get('/accounts')
      .then(res => {
        setAccounts(res.data.data)
      })
      .catch(err => console.log("Couldn't retrieve accounts."))
  }
  // load account list on render
  useEffect(() => {
    fetchData()
  }, [])

  // controls the state of modals display
  function toggleModal(type) {
    switch (type) {
      case 'account':
        setOpenModalAccount(!openModalAccount)
        break
      case 'deposit':
        setOpenModalDeposit(!openModalDeposit)
        break
      case 'transaction':
        setOpenModalTransaction(!openModalTransaction)
        break
      default:
        break
    }
  }
  // toggle the modals
  function openFormModal(type) {
    switch (type) {
      case 'account':
        toggleModal('account')
        break
      case 'deposit':
        toggleModal('deposit')
        break
      case 'transaction':
        toggleModal('transaction')
        break
      default:
        break
    }
  }

  return (
    <div className="home-cointainer">
      <section>
        <h2 className="home-title">Money Tracker</h2>
        <Button onClick={() => openFormModal('account')} squared>
          Add account
        </Button>
        <Button
          disabled={!accounts.length} // disable if there is no account to make deposits
          className="btn btn-deposit"
          onClick={() => openFormModal('deposit')}
          outline
          squared
          theme="success"
        >
          Deposit
        </Button>
        <Button
          disabled={accounts.length < 2} // disable if there are no 2 accounts to make transactions with
          className="btn btn-transaction"
          onClick={() => openFormModal('transaction')}
          outline
          squared
          theme="info"
        >
          Transaction
        </Button>
      </section>

      <AccountsTable accounts={accounts} />

      <Modal
        size="md"
        open={openModalAccount}
        toggle={() => toggleModal('account')}
      >
        <ModalHeader>Add account</ModalHeader>
        <ModalBody>
          <AccountForm
            setAccounts={setAccounts}
            accounts={accounts}
            setOpenModalAccount={setOpenModalAccount}
            swal={swal}
          />
        </ModalBody>
      </Modal>

      <Modal
        size="md"
        open={openModalDeposit}
        toggle={() => toggleModal('deposit')}
      >
        <ModalHeader>Make deposit</ModalHeader>
        <ModalBody>
          <DepositForm
            swal={swal}
            setOpenModalDeposit={setOpenModalDeposit}
            fetchData={fetchData}
            accounts={accounts}
          />
        </ModalBody>
      </Modal>

      <Modal
        size="md"
        open={openModalTransaction}
        toggle={() => toggleModal('transaction')}
      >
        <ModalHeader>Make transaction</ModalHeader>
        <ModalBody>
          <TransactionForm
            swal={swal}
            setOpenModalTransaction={setOpenModalTransaction}
            fetchData={fetchData}
            accounts={accounts}
          />
        </ModalBody>
      </Modal>
    </div>
  )
}
