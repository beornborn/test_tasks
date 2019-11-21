//@flow
import { connect } from 'react-redux'
import { reduxForm, reset } from 'redux-form'
import FilterForm from 'components/pages/activities/FilterForm'
import { fetchActivities } from 'reducers/Saga'
import { setActivityFilter } from 'reducers/App'
import { validateDateRange } from 'utils/Validation'

export const form = {
  form: 'activity/filter',
  validate: (values: Object, _props: Object) => {
    if (!values) return {}
    const { start, end } = values

    const validationErrors = {
      start: validateDateRange(start, end, 'From should be <= To'),
    }
    return validationErrors
  }
}

export const mapStateToProps = (_state: Object): Object => {
  return {}
}

export const mapDispatchToProps = (dispatch: Function): Object => ({
  resetFilter: () => {
    dispatch(setActivityFilter({}))
    dispatch(reset(form.form))
    dispatch(fetchActivities())
  },
  onSubmit: (formData: Object) => {
    dispatch(setActivityFilter(formData))
    dispatch(fetchActivities())
  },
})

const wrappedForm = reduxForm(form)(FilterForm)
export default connect(mapStateToProps, mapDispatchToProps)(wrappedForm)
