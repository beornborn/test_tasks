//@flow
import React from 'react'
import pt from 'prop-types'
import Activity from 'containers/pages/activities/Activity'
import FilterForm from 'containers/pages/activities/FilterForm'
import { FlatButton } from 'material-ui'
import { InternalLink } from 'components/shared/Shared.style'
import { Container, Content, Actions, NewActivityButton } from './ActivityList.style'

export default class ActivityList extends React.Component<*> {
  static propTypes = {
    activities: pt.arrayOf(pt.object).isRequired,
    fetchActivities: pt.func.isRequired,
  }

  componentDidMount() {
    this.props.fetchActivities()
  }

  render() {
    const { activities } = this.props

    return <Container>
      <Content>
        <Actions>
          <FilterForm />
          <NewActivityButton>
            <InternalLink to='/activities/new'>
              <FlatButton primary={true}>
                NEW ACTIVITY
              </FlatButton>
            </InternalLink>
          </NewActivityButton>
        </Actions>
        {activities.map(a =>
          <Activity key={a.id} activity={a} />
        )}
      </Content>
    </Container>
  }
}
