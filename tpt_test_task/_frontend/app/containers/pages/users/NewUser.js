//@flow
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'
import NewUser from 'components/pages/users/NewUser'
import { createUser } from 'reducers/Saga'
import { validatePresence, validateEmailSignature, validatePassword, validateWorkingMinutes } from 'utils/Validation'

export const form = {
  form: 'user/create',
  enableReinitialize: true,
  validate: (values: Object, _props: Object) => {
    if (!values) return {}
    const { name, email, password, working_minutes } = values
    const validationErrors = {
      name: validatePresence(name, 'Name is required'),
      email: validatePresence(email, 'Email is required') || validateEmailSignature(email),
      password: validatePresence(password, 'Choose a password, please') || validatePassword(password),
      working_minutes: working_minutes ? validateWorkingMinutes(working_minutes) : null,
    }
    return validationErrors
  }
}

export const mapStateToProps = (_state: Object): Object => {
  return {
  }
}

export const mapDispatchToProps = (dispatch: Function): Object => ({
  onSubmit: (formData: Object) => {
    return new Promise((resolve, reject) =>
      dispatch(createUser(formData, resolve, reject))
    )
  }
})

const wrappedForm = reduxForm(form)(NewUser)
wrappedForm.displayName = 'NewUser' // for authorization

export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
