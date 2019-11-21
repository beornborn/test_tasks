//@flow
import React from 'react'
import pt from 'prop-types'
import { Field } from 'redux-form'
import { RaisedButton } from 'material-ui'
import { TextField } from 'redux-form-material-ui'
import { HeightSeparator, InternalLink, ErrorContainer } from 'components/shared/Shared.style'
import { Container, Form, LinkContainer } from './Signin.style'

export default class Signin extends React.Component<*> {
  static propTypes = {
    handleSubmit: pt.func.isRequired,
    error: pt.string,
  }

  static defaultProps = { error: undefined }

  render() {
    const { handleSubmit, error } = this.props

    return <Container>
      <Form onSubmit={handleSubmit} >
        {error && <ErrorContainer>{error}</ErrorContainer>}
        <Field name='email' component={TextField} hintText='email' />
        <Field name='password' component={TextField} hintText='password' type='password' />
        <HeightSeparator height={30} />
        <RaisedButton label='Login' type='submit' primary={true} />
        <LinkContainer>
          <InternalLink to='/signup'>
            or, create account
          </InternalLink>
        </LinkContainer>
      </Form>
    </Container>
  }
}
