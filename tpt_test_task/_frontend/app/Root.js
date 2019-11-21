//@flow
import React from 'react'
import { render } from 'react-dom'
import { browserHistory, Router, Route, Redirect } from 'react-router'
import { Provider } from 'react-redux'
import { authenticate } from 'reducers/Saga'

import Layout from 'containers/layout/Layout'
import Signin from 'containers/pages/auth/signin/Signin'
import Signup from 'containers/pages/auth/signup/Signup'
import UserList from 'containers/pages/users/UserList'
import NewUser from 'containers/pages/users/NewUser'
import EditUser from 'containers/pages/users/EditUser'
import ActivityList from 'containers/pages/activities/ActivityList'
import NewActivity from 'containers/pages/activities/NewActivity'
import EditActivity from 'containers/pages/activities/EditActivity'

import authorize from 'containers/pages/auth/authorizer/Authorizer'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider'

import store from 'Store'
import 'assets/styles/global.css'

import moment from 'moment'
import momentDurationFormatSetup from 'moment-duration-format'
momentDurationFormatSetup(moment)

const callback = () => {
  render(
    <Provider store={store}>
      <div style={{height: '100%'}}>
        <MuiThemeProvider>
          <Router history={browserHistory}>
            <Redirect from='/' to='/signin' />
            <Route path='/signin' component={authorize(Signin)} />
            <Route path='/signup' component={authorize(Signup)} />
            <Route path='/' component={Layout}>
              <Route path='users' component={authorize(UserList)} />
              <Route path='users/new' component={authorize(NewUser)} />
              <Route path='users/:id' component={authorize(EditUser)} />
              <Route path='activities' component={authorize(ActivityList)} />
              <Route path='activities/new' component={authorize(NewActivity)} />
              <Route path='activities/:id' component={authorize(EditActivity)} />
            </Route>
          </Router>
        </MuiThemeProvider>
      </div>
    </Provider>,
    // $FlowIgnore
    document.getElementById('root')
  )
}

store.dispatch(authenticate(callback))
