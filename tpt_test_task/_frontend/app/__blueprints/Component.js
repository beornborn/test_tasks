//@flow
import React from 'react'
import pt from 'prop-types'

export default class Component extends React.Component<*> {
  static propTypes = {
    prop: pt.string.isRequired,
  }

  render() {
    return <div>
      test
    </div>
  }
}
