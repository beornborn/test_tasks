//@flow
import { connect } from 'react-redux'
import Authorizer from 'components/pages/auth/authorizer/Authorizer'
import { getPermissions } from 'reducers/selectors/App'
import { getCurrentUser } from 'reducers/selectors/Data'

const authorize = (Component: Object) => {
  const mapStateToProps = (state: Object): Object => ({
    Component,
    user: getCurrentUser(state),
    permissions: getPermissions(state)
  })

  return connect(mapStateToProps, null)(Authorizer)
}

export default authorize
