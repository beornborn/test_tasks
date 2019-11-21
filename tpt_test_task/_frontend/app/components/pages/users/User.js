//@flow
import React from 'react'
import pt from 'prop-types'
import DeleteIcon from 'react-icons/lib/md/delete'
import { palette } from 'Theme'
import { InternalLink } from 'components/shared/Shared.style'
import moment from 'moment'
import { Container, Name, Content, Label, Row, Header } from './User.style'


export default class User extends React.Component<*> {
  static propTypes = {
    user: pt.object.isRequired,
    deleteUser: pt.func.isRequired,
  }

  render() {
    const { user, deleteUser } = this.props

    return <Container>
      <Header>
        <Name>
          <InternalLink to={`/users/${user.id}`}>{user.name}</InternalLink>
        </Name>
        <DeleteIcon
          style={{cursor: 'pointer'}}
          fill={palette.secondary}
          onClick={() => deleteUser(user.id)} />
      </Header>
      <Content>
        <Row>
          <Label>email:</Label>{user.email}
        </Row>
        <Row>
          <Label>hours:</Label>{moment.duration(user.working_minutes, 'minutes').format('h [hrs] m [min]')}
        </Row>
      </Content>
    </Container>
  }
}
