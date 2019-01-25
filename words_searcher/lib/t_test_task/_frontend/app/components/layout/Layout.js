//@flow
import React from 'react'
import pt from 'prop-types'
import { Snackbar } from 'material-ui'
import Header from 'containers/layout/Header'

export default class Layout extends React.Component<*> {
  static propTypes = {
    children: pt.element.isRequired,
    location: pt.object.isRequired,
    snackbar: pt.object.isRequired,
    hideSnackbar: pt.func.isRequired,
  }

  static displayName = 'Layout'

  render() {
    const { children, location, snackbar, hideSnackbar } = this.props

    return <div>
      <Snackbar
        open={snackbar.open}
        message={snackbar.message}
        autoHideDuration={4000}
        onRequestClose={hideSnackbar} />
      <Header pathname={location.pathname} />
      {children}
    </div>
  }
}
