//@flow
import React from 'react'
import pt from 'prop-types'
import User from 'containers/pages/users/User'
import { FlatButton } from 'material-ui'
import { InternalLink } from 'components/shared/Shared.style'
import { Container, Content, Actions } from './UserList.style'

export default class UserList extends React.Component<*> {
  static propTypes = {
    users: pt.arrayOf(pt.object).isRequired,
    fetchUsers: pt.func.isRequired,
  }

  componentDidMount() {
    this.props.fetchUsers()
  }

  render() {
    const { users } = this.props

    return <Container>
      <Content>
        <Actions>
          <InternalLink to='/users/new'>
            <FlatButton primary={true}>
              NEW USER
            </FlatButton>
          </InternalLink>
        </Actions>
        {users.map(u =>
          <User key={u.id} user={u} />
        )}
      </Content>
    </Container>
  }
}
