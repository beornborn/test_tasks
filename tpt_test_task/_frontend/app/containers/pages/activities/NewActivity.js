//@flow
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'
import NewActivity from 'components/pages/activities/NewActivity'
import { createActivity, fetchUsers } from 'reducers/Saga'
import { getPermissions } from 'reducers/selectors/App'
import { getCurrentUser, getUsers } from 'reducers/selectors/Data'
import { validatePresence, validateWorkingMinutes, validateLength } from 'utils/Validation'
import { isEmpty } from 'lodash'

export const form = {
  form: 'activity/create',
  enableReinitialize: true,
  validate: (values: Object, _props: Object) => {
    if (!values) return {}
    const { description, start, user_id, duration } = values

    const validationErrors = {
      description: validatePresence(description, 'Description is required') ||
        validateLength(description, 200, 'Description should be < 200 symbols'),
      start: validatePresence(start, 'Start is required'),
      user_id: validatePresence(user_id, 'User is required'),
      duration: validatePresence(duration, 'Duration is required') || validateWorkingMinutes(duration),
    }
    return validationErrors
  }
}

export const mapStateToProps = (state: Object): Object => {
  const p = getPermissions(state)
  const user = getCurrentUser(state)
  const users = getUsers(state)
  return {
    users: isEmpty(users) ? [user] : users,
    initialValues: {
      user_id: p.isRegular ? user.id : null,
    },
  }
}

export const mapDispatchToProps = (dispatch: Function): Object => ({
  fetchUsers: () => dispatch(fetchUsers()),
  onSubmit: (formData: Object) => {
    return new Promise((resolve, reject) =>
      dispatch(createActivity(formData, resolve, reject))
    )
  }
})

const wrappedForm = reduxForm(form)(NewActivity)
wrappedForm.displayName = 'NewActivity' // for authorization

export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
