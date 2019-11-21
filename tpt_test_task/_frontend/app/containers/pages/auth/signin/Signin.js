//@flow
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'
import Signin from 'components/pages/auth/signin/Signin'
import { signIn } from 'reducers/Saga'
import { validatePresence, validateEmailSignature, validatePassword } from 'utils/Validation'

export const form = {
  form: 'auth/signin',
  validate: (values: Object, _props: Object) => {
    if (!values) return {}
    const { email, password } = values

    return {
      email: validatePresence(email, 'Tyoe your email') || validateEmailSignature(email),
      password: validatePresence(password, 'Type your password') || validatePassword(password)
    }
  }
}

export const mapStateToProps = (_state: Object): Object => ({
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  onSubmit: (formData: Object) =>
    new Promise((resolve, reject) =>
      dispatch(signIn(formData, resolve, reject))
    ),
})

const wrappedForm = reduxForm(form)(Signin)
wrappedForm.displayName = 'Signin'

export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
