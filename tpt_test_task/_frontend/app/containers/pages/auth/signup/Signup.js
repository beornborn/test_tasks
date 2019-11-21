//@flow
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'
import Signup from 'components/pages/auth/signup/Signup'
import { signUp } from 'reducers/Saga'
import { validatePresence, validateEmailSignature, validatePassword } from 'utils/Validation'

export const form = {
  form: 'auth/signup',
  validate: (values: Object, _props: Object) => {
    if (!values) return {}
    const { name, email, password } = values

    return {
      name: validatePresence(name, 'Name is required'),
      email: validatePresence(email, 'Email is required') || validateEmailSignature(email),
      password: validatePresence(password, 'Choose a password, please') || validatePassword(password)
    }
  }
}

export const mapStateToProps = (_state: Object): Object => ({
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  onSubmit: (formData: Object) => {
    return new Promise((resolve, reject) =>
      dispatch(signUp(formData, resolve, reject))
    )
  },
})

const wrappedForm = reduxForm(form)(Signup)
wrappedForm.displayName = 'Signup' // for authorization

export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
