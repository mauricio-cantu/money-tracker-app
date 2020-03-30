import React, { useState } from 'react'
import api from '../../services/api'
import { MdArrowForward, MdDone } from 'react-icons/md'
import {
  Col,
  FormGroup,
  FormSelect,
  InputGroup,
  InputGroupText,
  InputGroupAddon,
  FormInput,
  Button,
  Form,
  Row
} from 'shards-react'
export default function TransactionForm(props) {
  // transaction form states
  const [accountFromId, setAccountFromId] = useState('')
  const [accountToId, setAccountToId] = useState('')
  const [transactionValue, setTransactionValue] = useState('')

  // sends a transaction to server
  async function handleMakeTransaction(e) {
    e.preventDefault()
    const data = {
      id_from: accountFromId,
      id_to: accountToId,
      value: transactionValue
    }

    // tries to perform the transaction
    api
      .post('transactions', data)
      .then(res => {
        props.fetchData()
        setAccountFromId(0)
        setAccountToId(0)
        setTransactionValue(0)
        props.swal.fire({
          title: res.data.message,
          icon: 'success'
        })
        // close modal
        props.setOpenModalTransaction()
      })
      .catch(err => {
        props.swal.fire({
          title: !err.response ? 'Network error.' : err.response.data.message,
          icon: 'error'
        })
      })
  }

  return (
    <Form onSubmit={handleMakeTransaction}>
      <Row>
        <Col>
          <FormGroup>
            <FormSelect
              name="account_from_id"
              onChange={e => setAccountFromId(e.target.value)}
              value={accountFromId}
              required
            >
              <option disabled defaultValue value="">
                Choose an account
              </option>
              {props.accounts.map(el => (
                <option value={el.id} key={el.id}>
                  {el.title}
                </option>
              ))}
            </FormSelect>
          </FormGroup>
        </Col>
        <span style={{ marginTop: 5 }}>
          <MdArrowForward size={30} />
        </span>
        <Col>
          <FormGroup>
            <FormSelect
              name="account_to_id"
              onChange={e => setAccountToId(e.target.value)}
              value={accountToId}
              required
            >
              <option disabled defaultValue value="">
                Choose an account
              </option>
              {props.accounts.map(el => (
                <option value={el.id} key={el.id}>
                  {el.title}
                </option>
              ))}
            </FormSelect>
          </FormGroup>
        </Col>
      </Row>
      <FormGroup>
        <InputGroup>
          <InputGroupAddon type="prepend">
            <InputGroupText>R$</InputGroupText>
          </InputGroupAddon>
          <FormInput
            name="value"
            placeholder="Transaction value"
            onChange={e => setTransactionValue(e.target.value)}
            required
          />
        </InputGroup>
      </FormGroup>
      <Button squared theme="success" type="submit">
        <span>
          <MdDone />
        </span>
      </Button>
    </Form>
  )
}
