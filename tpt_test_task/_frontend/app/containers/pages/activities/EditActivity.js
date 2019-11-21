//@flow
import { connect } from 'react-redux'
import { reduxForm } from 'redux-form'
import NewActivity from 'components/pages/activities/NewActivity'
import { updateActivity, fetchUsers, fetchActivity } from 'reducers/Saga'
import { getSelectedActivity } from 'reducers/selectors/App'
import { getUsers, getCurrentUser } from 'reducers/selectors/Data'
import moment from 'moment'
import { isEmpty } from 'lodash'
import { validatePresence, validateWorkingMinutes, validateLength } from 'utils/Validation'

export const form = {
  form: 'activity/update',
  enableReinitialize: true,
  validate: (values: Object) => {
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
  const activity = getSelectedActivity(state)
  const user = getCurrentUser(state)
  const users = getUsers(state)
  return {
    users: isEmpty(users) ? [user] : users,
    initialValues: {
      description: activity.description,
      start: activity.start ? new Date(activity.start) : '',
      user_id: activity.user_id,
      duration: moment.duration(activity.duration, 'minutes').format('h:m'),
    }
  }
}

export const mapDispatchToProps = (dispatch: Function): Object => ({
  fetchActivity: (id: string | number) => dispatch(fetchActivity(id)),
  fetchUsers: () => dispatch(fetchUsers()),
  onSubmit: (formData: Object) => {
    return new Promise((resolve, reject) =>
      dispatch(updateActivity(formData, resolve, reject))
    )
  }
})

const wrappedForm = reduxForm(form)(NewActivity)
wrappedForm.displayName = 'EditActivity' // for authorization

export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
