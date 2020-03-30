import React, { useState } from 'react'
import api from '../../services/api'
import {
  Form,
  FormGroup,
  InputGroup,
  InputGroupAddon,
  InputGroupText,
  FormInput,
  Button,
  FormSelect
} from 'shards-react'
import { MdDone } from 'react-icons/md'
export default function DepositForm(props) {
  // deposit form states
  const [accountId, setAccountId] = useState('')
  const [depositValue, setDepositValue] = useState('')

  // sends a deposit to server
  async function handleMakeDeposit(e) {
    e.preventDefault()

    const data = {
      id: accountId,
      value: depositValue
    }
    // tries to perform the deposit
    api
      .post('deposits', data)
      .then(res => {
        props.fetchData()
        setAccountId(0)
        setDepositValue(0)
        props.swal.fire({
          title: res.data.message,
          icon: 'success'
        })
        // close modal
        props.setOpenModalDeposit()
      })
      .catch(err => {
        props.swal.fire({
          title: !err.response ? 'Network error.' : err.response.data.message,
          icon: 'error'
        })
      })
  }

  return (
    <Form onSubmit={handleMakeDeposit}>
      <FormGroup>
        <FormSelect
          name="account_id"
          value={accountId}
          onChange={e => setAccountId(e.target.value)}
          required
        >
          <option disabled defaultValue value="">
            Choose an account
          </option>
          {props.accounts.map(el => (
            <option key={el.id} value={el.id}>
              {el.title}
            </option>
          ))}
        </FormSelect>
      </FormGroup>
      <FormGroup>
        <InputGroup>
          <InputGroupAddon type="prepend">
            <InputGroupText>R$</InputGroupText>
          </InputGroupAddon>
          <FormInput
            name="value"
            onChange={e => setDepositValue(e.target.value)}
            placeholder="Deposit value"
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
