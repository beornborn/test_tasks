//@flow
import React from 'react'
import pt from 'prop-types'
import { Field } from 'redux-form'
import { RaisedButton } from 'material-ui'
import { TextField } from 'redux-form-material-ui'
import { HeightSeparator, InternalLink } from 'components/shared/Shared.style'
import { Container, Form, LinkContainer } from './Signup.style'

export default class Signin extends React.Component<*> {
  static propTypes = {
    handleSubmit: pt.func.isRequired,
  }

  render() {
    const { handleSubmit } = this.props

    return <Container>
      <Form onSubmit={handleSubmit} >
        <Field name='name' component={TextField} hintText='name' />
        <Field name='email' component={TextField} hintText='email' />
        <Field name='password' component={TextField} hintText='password' type='password' />
        <HeightSeparator height={30} />
        <RaisedButton label='Create Account' type='submit' primary={true} />
        <LinkContainer>
          <InternalLink to='/signin'>
            or, login
          </InternalLink>
        </LinkContainer>
      </Form>
    </Container>
  }
}
