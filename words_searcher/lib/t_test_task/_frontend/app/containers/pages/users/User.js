//@flow
import { connect } from 'react-redux'
import User from 'components/pages/users/User'
import { deleteUser } from 'reducers/Saga'

export const mapStateToProps = (_state: Object): Object => ({

})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  deleteUser: (id: number) => dispatch(deleteUser(id))
})

export default connect(mapStateToProps, mapDispatchToProps)(User)
