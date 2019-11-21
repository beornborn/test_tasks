//@flow
import { connect } from 'react-redux'
import ActivityList from 'components/pages/activities/ActivityList'
import { getActivities } from 'reducers/selectors/Data'
import { fetchActivities } from 'reducers/Saga'

export const mapStateToProps = (state: Object): Object => ({
  activities: getActivities(state),
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  fetchActivities: () => dispatch(fetchActivities()),
})

ActivityList.displayName = 'ActivityList'

export default connect(mapStateToProps, mapDispatchToProps)(ActivityList)
