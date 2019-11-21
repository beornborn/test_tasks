//@flow
import { connect } from 'react-redux'
import UserList from 'components/pages/users/UserList'
import { getUsers } from 'reducers/selectors/Data'
import { fetchUsers } from 'reducers/Saga'

export const mapStateToProps = (state: Object): Object => ({
  users: getUsers(state),
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  fetchUsers: () => dispatch(fetchUsers()),
})

UserList.displayName = 'UserList'

export default connect(mapStateToProps, mapDispatchToProps)(UserList)
