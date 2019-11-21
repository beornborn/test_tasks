//@flow
import React from 'react'
import pt from 'prop-types'
import { Field } from 'redux-form'
import { RaisedButton, MenuItem } from 'material-ui'
import { TextField, SelectField, DatePicker } from 'redux-form-material-ui'
import { HeightSeparator } from 'components/shared/Shared.style'
import { Container, Content } from './NewActivity.style'

export default class NewActivity extends React.Component<*> {
  static propTypes = {
    handleSubmit: pt.func.isRequired,
    fetchActivity: pt.func,
    fetchUsers: pt.func.isRequired,
    users: pt.arrayOf(pt.object).isRequired,
    params: pt.object.isRequired,
  }

  static defaultProps = { fetchActivity: () => {} }

  componentDidMount() {
    const { params, fetchActivity, fetchUsers } = this.props
    if (params.id) fetchActivity(params.id)
    fetchUsers()
  }

  render() {
    const { handleSubmit, params, users } = this.props
    const label = params.id ? 'Update' : 'Create Activity'

    return <Container>
      <Content>
        <form onSubmit={handleSubmit} >
          <Field name='description' component={TextField}
            multiLine={true}
            rows={2}
            floatingLabelText='Description'
            fullWidth={true} />
          <Field name='start' component={DatePicker}
            floatingLabelText='Start date'
            maxDate={new Date()}
            fullWidth={true} />
          <Field name='duration' component={TextField}
            floatingLabelText='Worked time'
            fullWidth={true}
            hintText='hh:mm' />
          <Field name='user_id' component={SelectField}
            floatingLabelText='User'
            fullWidth={true} >
            {users.map(u =>
              <MenuItem key={u.id} value={u.id} primaryText={u.name} />
            )}
          </Field>
          <HeightSeparator height={30} />
          <RaisedButton label={label} type='submit' primary={true} />
        </form>
      </Content>
    </Container>
  }
}
