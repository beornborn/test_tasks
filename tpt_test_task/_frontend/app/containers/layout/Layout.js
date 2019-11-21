//@flow
import { connect } from 'react-redux'
import Layout from 'components/layout/Layout'
import { getSnackbar } from 'reducers/selectors/Ui'
import { hideSnackbar } from 'reducers/Ui'

export const mapStateToProps = (state: Object): Object => ({
  snackbar: getSnackbar(state),
})

export const mapDispatchToProps = (dispatch: Function): Object => ({
  hideSnackbar: () => dispatch(hideSnackbar())
})

export default connect(mapStateToProps, mapDispatchToProps)(Layout)
