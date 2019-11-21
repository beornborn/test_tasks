//@flow
import React from 'react'
import pt from 'prop-types'
import { browserHistory } from 'react-router'
import Acl from 'components/pages/auth/authorizer/Acl'
import { omit } from 'lodash'

export default class Authorizer extends React.Component<*> {
  static propTypes = {
    Component: pt.oneOfType([pt.element, pt.func]).isRequired,
    user: pt.object.isRequired,
    permissions: pt.object.isRequired,
    params: pt.object.isRequired,
  }

  componentWillMount() { this.authorize() }
  componentDidUpdate() { this.authorize() }

  redirects = (componentName: string) => {
    const { user, permissions: p } = this.props

    return {
      UserList: (user.id && '/activities') || '/signin',
      NewUser: (user.id && '/activities') || '/signin',
      EditUser: (user.id && '/activities') || '/signin',
      ActivityList: (user.id && '/users') || '/signin',
      NewActivity: (user.id && '/users') || '/signin',
      EditActivity: (user.id && '/users') || '/signin',
      Signin: ((p.isAdmin || p.isRegular) && '/activities') || (p.isManager && '/users'),
      Signup: ((p.isAdmin || p.isRegular) && '/activities') || (p.isManager && '/users'),
    }[componentName]
  }

  authorize() {
    const { Component } = this.props

    if (!this.isAuthorized()) {
      const componentName = this.componentName(Component)
      browserHistory.push(this.redirects(componentName))
    }
  }

  componentName(Component: Object) {
    if (Component.WrappedComponent) {
      return Component.WrappedComponent.displayName
    }

    return Component.displayName
  }

  isAuthorized() {
    const { user, Component, permissions, params } = this.props
    const componentName = this.componentName(Component)
    const authorizer = Acl[componentName]
    return authorizer(user, permissions, params)
  }

  render() {
    const { Component } = this.props

    if (this.isAuthorized()) {
      return <Component {...omit(this.props, ['user', 'permissions', 'Component'])} />
    }
    return null
  }
}
