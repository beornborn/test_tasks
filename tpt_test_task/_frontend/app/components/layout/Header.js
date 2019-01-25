//@flow
import React from 'react'
import pt from 'prop-types'
import { Link } from 'react-router'
import { FlatButton } from 'material-ui'
import { InternalLink } from 'components/shared/Shared.style'
import { Container, LinkText, Spacer, Name } from './Header.style'

export default class Header extends React.Component<*> {
  static propTypes = {
    permissions: pt.object.isRequired,
    pathname: pt.string.isRequired,
    user: pt.object.isRequired,
    doLogout: pt.func.isRequired,
  }

  render() {
    const { permissions: p, pathname, user, doLogout } = this.props

    return <Container>
      {!p.isRegular && <Link to='/users'>
        <LinkText active={pathname.includes('users')}>USERS</LinkText>
      </Link>}
      {!p.isManager && <Link to='/activities'>
        <LinkText active={pathname.includes('activities')}>ACTIVITIES</LinkText>
      </Link>}
      <Spacer />
      <InternalLink to={`/users/${user.id}`}>Edit</InternalLink>
      <Name>{user.name}</Name>
      <FlatButton secondary={true} onClick={doLogout}>
        LOGOUT
      </FlatButton>
    </Container>
  }
}
