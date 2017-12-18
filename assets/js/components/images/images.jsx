import {Socket} from 'phoenix'
import React from 'react'
import PropTypes from 'prop-types'
import Grid from './grid'

class Images extends React.Component {
  propTypes: {
    images: PropTypes.array,
    vacId: PropTypes.number
  }

  constructor (props) {
    console.log('constructing')
    super()
    let socket = new Socket('/socket', {params: {token: window.userToken}})
    socket.connect()
    let channel = socket.channel(`vac:images:${props.vacId}`, {})
    this.state = {channel: channel, images: props.images, ref: null}
    this.state.channel.join()
  }

  componentDidMount () {
    const ref = this.state.channel.on('new_images', payload => {
      const newImages = this.state.images.concat(payload.images)
      this.setState({images: newImages})
    })

    this.setState({ref: ref})
  }

  componentWillUnmount () {
    this.state.chan.off('new_images', this.state.ref)
  }

  render () {
    return (
      <Grid images={this.state.images} />
    )
  }
}

export default Images
