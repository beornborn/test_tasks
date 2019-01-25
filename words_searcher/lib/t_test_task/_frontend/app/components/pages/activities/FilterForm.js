//@flow
import React from 'react'
import pt from 'prop-types'
import { Field } from 'redux-form'
import { FlatButton } from 'material-ui'
import { DatePicker } from 'redux-form-material-ui'
import { Container, Form } from './FilterForm.style'

export default class FilterForm extends React.Component<*> {
  static propTypes = {
    handleSubmit: pt.func.isRequired,
    resetFilter: pt.func.isRequired,
  }

  render() {
    const { handleSubmit, resetFilter } = this.props

    return <Container>
      <Form onSubmit={handleSubmit} >
        <Field name='start' component={DatePicker}
          floatingLabelText='From'
          maxDate={new Date()}
          textFieldStyle={{width: 150, marginRight: 20}} />
        <Field name='end' component={DatePicker}
          floatingLabelText='To'
          maxDate={new Date()}
          textFieldStyle={{width: 150, marginRight: 20}} />
        <FlatButton label='Filter' type='submit' primary={true}
          style={{position: 'relative', top: 25}}
          labelStyle={{fontSize: 16}} />
        <FlatButton label='Clear' secondary={true}
          style={{position: 'relative', top: 25}}
          labelStyle={{fontSize: 16}}
          onClick={resetFilter} />
      </Form>
    </Container>
  }
}
