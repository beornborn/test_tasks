//@flow
import React from 'react'
import pt from 'prop-types'
import { Field } from 'redux-form'
import { RaisedButton } from 'material-ui'
import { TextField } from 'redux-form-material-ui'
import { HeightSeparator } from 'components/shared/Shared.style'
import { Container, Content } from './NewUser.style'

export default class NewUser extends React.Component<*> {
  static propTypes = {
    handleSubmit: pt.func.isRequired,
    fetchUser: pt.func,
    params: pt.object.isRequired
  }

  static defaultProps = { fetchUser: () => {} }

  componentDidMount() {
    const { params, fetchUser } = this.props
    if (params.id) fetchUser(params.id)
  }

  render() {
    const { handleSubmit, params } = this.props
    const label = params.id ? 'Update' : 'Create User'

    return (
      <Container>
        <Content>
          <form onSubmit={handleSubmit}>
            <Field
              name="name"
              component={TextField}
              floatingLabelText="Name"
              fullWidth={true}
            />
            <Field
              name="email"
              component={TextField}
              floatingLabelText="Email"
              fullWidth={true}
            />
            <Field
              name="password"
              component={TextField}
              floatingLabelText="Password"
              type="password"
              fullWidth={true}
            />
            <Field
              name="working_minutes"
              component={TextField}
              floatingLabelText="Preferred working hours"
              fullWidth={true}
              hintText="hh:mm"
            />
            <HeightSeparator height={30} />
            <RaisedButton label={label} type="submit" primary={true} />
          </form>
        </Content>
      </Container>
    )
  }
}
