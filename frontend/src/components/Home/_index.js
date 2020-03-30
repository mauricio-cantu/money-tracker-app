import React, { useState, useEffect } from 'react'
import { MdArrowForward } from 'react-icons/md'
import './styles.css'
import {
  Button,
  FormInput,
  InputGroup,
  InputGroupAddon,
  InputGroupText,
  FormGroup,
  FormSelect,
  Form,
  Row,
  Col,
  Modal,
  ModalBody,
  ModalHeader
} from 'shards-react'
import AccountsTable from '../AccountsTable'
import api from '../../services/api'
import Swal from 'sweetalert2'
import withReactContent from 'sweetalert2-react-content'

export default function Home() {
  const [accounts = [], setAccounts] = useState([])
  const [accountTitle, setAccountTitle] = useState('')
  const [accountBalance, setAccountBalance] = useState('')

  async function handleNewAccount(e) {
    e.preventDefault()
    const data = {
      title: accountTitle,
      balance: accountBalance
    }

    try {
      const res = await api.post('accounts', { account: data })
      console.log('res', res)
    } catch (err) {
      alert('Erro')
    }
  }

  const swal = withReactContent(Swal).mixin({
    customClass: {
      confirmButton: 'btn btn-success btn-squared',
      cancelButton: 'btn btn-danger btn-squared'
    },
    showConfirmButton: false,
    buttonsStyling: false
  })

  useEffect(() => {
    async function fetchData() {
      await api
        .get('/accounts')
        .then(res => {
          setAccounts(res.data.data)
        })
        .catch(err => {
          console.log("Couldn't retrieve accounts.")
        })
    }
    fetchData()
  }, [])

  function openFormModal(type) {
    switch (type) {
      case 'account':
        swal.fire({
          title: 'Add account',
          html: (
            <>
              <Form onSubmit={handleNewAccount}>
                <FormGroup>
                  <FormInput
                    name="title"
                    id="account_title"
                    autoFocus
                    placeholder="Account title"
                    // value={accountTitle}
                    onChange={e => setAccountTitle(e.target.value)}
                  />
                </FormGroup>
                <FormGroup>
                  <InputGroup>
                    <InputGroupAddon type="prepend">
                      <InputGroupText>R$</InputGroupText>
                    </InputGroupAddon>
                    <FormInput
                      name="balance"
                      id="account_balance"
                      placeholder="Initial balance"
                      // value={accountBalance}
                      onChange={e => setAccountBalance(e.target.value)}
                    />
                  </InputGroup>
                </FormGroup>
                <Button squared theme="success" type="submit">
                  Ok
                </Button>
              </Form>
            </>
          ),
          preConfirm: () => {
            return {
              title: document.getElementById('account_title').value,
              balance: document.getElementById('account_balance').value
            }
          }
        })
        break
      case 'deposit':
        swal.fire({
          title: 'Make deposit',
          html: (
            <>
              <Form>
                <FormGroup>
                  <FormSelect name="account_id">
                    <option value="1">Bank 1</option>
                    <option value="2">Bank 2</option>
                    <option value="3">Wallet</option>
                  </FormSelect>
                </FormGroup>
                <FormGroup>
                  <InputGroup>
                    <InputGroupAddon type="prepend">
                      <InputGroupText>R$</InputGroupText>
                    </InputGroupAddon>
                    <FormInput name="value" placeholder="Deposit value" />
                  </InputGroup>
                </FormGroup>
              </Form>
            </>
          )
        })
        break
      case 'transaction':
        swal.fire({
          title: 'Make transaction',
          html: (
            <div>
              <Form>
                <Row>
                  <Col>
                    <FormGroup>
                      <FormSelect name="account_from_id">
                        <option value="1">Bank 1</option>
                        <option value="2">Bank 2</option>
                        <option value="3">Wallet</option>
                      </FormSelect>
                    </FormGroup>
                  </Col>
                  <span style={{ 'margin-top': 5 }}>
                    <MdArrowForward size={30} />
                  </span>
                  <Col>
                    <FormGroup>
                      <FormSelect name="account_to_id">
                        <option value="1">Bank 1</option>
                        <option value="2">Bank 2</option>
                        <option value="3">Wallet</option>
                      </FormSelect>
                    </FormGroup>
                  </Col>
                </Row>
                <FormGroup>
                  <InputGroup>
                    <InputGroupAddon type="prepend">
                      <InputGroupText>R$</InputGroupText>
                    </InputGroupAddon>
                    <FormInput name="value" placeholder="Transaction value" />
                  </InputGroup>
                </FormGroup>
              </Form>
            </div>
          )
        })
        break
      default:
        break
    }
  }

  return (
    <div className="home-cointainer">
      <section>
        <h2 className="home-title">Money Tracker</h2>
        <Button
          onClick={() => openFormModal('account')}
          className="btn"
          squared
        >
          Add account
        </Button>
        <Button
          disabled={!accounts.length} // disables if there is no account to make deposits
          className="btn btn-deposit"
          onClick={() => openFormModal('deposit')}
          outline
          squared
          theme="success"
        >
          Deposit
        </Button>
        <Button
          disabled={accounts.length < 2} // disables if there are no 2 accounts to make transactions with
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
    </div>
  )
}
