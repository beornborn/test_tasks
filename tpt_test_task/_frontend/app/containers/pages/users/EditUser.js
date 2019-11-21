//@flow
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'
import NewUser from 'components/pages/users/NewUser'
import { updateUser, fetchUser } from 'reducers/Saga'
import { getSelectedUser } from 'reducers/selectors/App'
import moment from 'moment'
import { validatePresence, validateEmailSignature, validatePassword, validateWorkingMinutes } from 'utils/Validation'

export const form = {
  form: 'user/update',
  enableReinitialize: true,
  validate: (values: Object, _props: Object) => {
    if (!values) return {}
    const { name, email, password, working_minutes } = values
    const validationErrors = {
      name: validatePresence(name, 'Name is required'),
      email: validatePresence(email, 'Email is required') || validateEmailSignature(email),
      password: password ? validatePassword(password) : null,
      working_minutes: working_minutes ? validateWorkingMinutes(working_minutes) : null,
    }
    return validationErrors
  }
}

export const mapStateToProps = (state: Object): Object => {
  const user = getSelectedUser(state)
  return {
    initialValues: {
      email: user.email,
      name: user.name,
      working_minutes: moment.duration(user.working_minutes, 'minutes').format('h:m'),
    }
  }
}

export const mapDispatchToProps = (dispatch: Function): Object => ({
  fetchUser: (id: string | number) => dispatch(fetchUser(id)),
  onSubmit: (formData: Object) => {
    return new Promise((resolve, reject) =>
      dispatch(updateUser(formData, resolve, reject))
    )
  }
})

const wrappedForm = reduxForm(form)(NewUser)
wrappedForm.displayName = 'EditUser' // for authorization

export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
