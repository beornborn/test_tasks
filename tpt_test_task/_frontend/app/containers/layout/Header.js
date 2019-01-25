//@flow
import { connect } from 'react-redux'
import Header from 'components/layout/Header'
import { getPermissions } from 'reducers/selectors/App'
import { getCurrentUser } from 'reducers/selectors/Data'
import { logout } from 'reducers/Saga'

export const mapStateToProps = (state: Object): Object => ({
  permissions: getPermissions(state),
  user: getCurrentUser(state),
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  doLogout: () => dispatch(logout()),
})

export default connect(mapStateToProps, mapDispatchToProps)(Header)
