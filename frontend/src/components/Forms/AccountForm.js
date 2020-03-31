import React, { useState } from 'react'
import {
  Form,
  FormGroup,
  InputGroup,
  InputGroupAddon,
  InputGroupText,
  FormInput,
  Button
} from 'shards-react'
import api from '../../services/api'
import { MdDone } from 'react-icons/md'

export default function AccountForm(props) {
  // new account form states
  const [accountTitle, setAccountTitle] = useState('')
  const [accountBalance, setAccountBalance] = useState('')

  // on submit of new account form
  async function handleAddAccount(e) {
    e.preventDefault()
    // new account data
    const data = {
      title: accountTitle,
      balance: accountBalance
    }
    // tries to create the account
    try {
      const res = await api.post('accounts', { account: data })
      props.setAccounts([...props.accounts, res.data.data])
      props.swal.fire({
        title: 'Account created successfully.',
        icon: 'success'
      })
      // closes modal
      props.setOpenModalAccount()
    } catch (err) {
      props.swal.fire({
        title: !err.response ? 'Network error.' : err.response.data.message,
        icon: 'error'
      })
    }
  }

  return (
    <Form onSubmit={handleAddAccount}>
      <FormGroup>
        <FormInput
          name="title"
          id="account_title"
          autoFocus
          placeholder="Account title"
          onChange={e => setAccountTitle(e.target.value)}
          required
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
            onChange={e => setAccountBalance(e.target.value)}
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
