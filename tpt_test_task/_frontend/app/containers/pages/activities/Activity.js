//@flow
import { connect } from 'react-redux'
import Activity from 'components/pages/activities/Activity'
import { deleteActivity } from 'reducers/Saga'
import { getCurrentUser } from 'reducers/selectors/Data'

export const mapStateToProps = (state: Object): Object => ({
  currentUser: getCurrentUser(state),
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  deleteActivity: (id: number) => dispatch(deleteActivity(id)),
})

export default connect(mapStateToProps, mapDispatchToProps)(Activity)
