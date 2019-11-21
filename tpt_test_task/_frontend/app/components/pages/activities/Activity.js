//@flow
import React from 'react'
import pt from 'prop-types'
import DeleteIcon from 'react-icons/lib/md/delete'
import { palette } from 'Theme'
import { InternalLink } from 'components/shared/Shared.style'
import moment from 'moment'
import { Container, Name, Content, Label, Row, Header } from './Activity.style'

export default class Activity extends React.Component<*> {
  static propTypes = {
    activity: pt.object.isRequired,
    currentUser: pt.object.isRequired,
    deleteActivity: pt.func.isRequired,
  }

  render() {
    const { activity, deleteActivity, currentUser } = this.props

    return <Container color={activity.color}>
      <Header>
        <Name>
          <InternalLink to={`/activities/${activity.id}`}>{activity.description}</InternalLink>
        </Name>
        <DeleteIcon
          style={{cursor: 'pointer'}}
          fill={palette.secondary}
          onClick={() => deleteActivity(activity.id)} />
      </Header>
      <Content>
        <Row>
          <Label>start:</Label>{activity.start}
        </Row>
        <Row>
          <Label>duration:</Label>{moment.duration(activity.duration, 'minutes').format('h [hrs] m [min]')}
        </Row>
        {activity.user && activity.user.id !== currentUser.id && (
          <Row>
            <Label>user:</Label>
            <InternalLink to={`/users/${activity.user_id}`}>{activity.user.name}</InternalLink>
          </Row>
        )}
      </Content>
    </Container>
  }
}
