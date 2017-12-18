import {Socket} from 'phoenix'
import React from 'react'
import PropTypes from 'prop-types'
import Grid from './grid'
import Loading from './loading'

class Images extends React.Component {
  static propTypes = {
    images: PropTypes.array,
    vacId: PropTypes.string,
    loading: PropTypes.bool
  }

  static defaultProps = {
    loading: true
  }

  constructor (props) {
    super()
    let socket = new Socket('/socket', {params: {token: window.userToken}})
    socket.connect()
    let channel = socket.channel(`vac:images:${props.vacId}`, {})
    this.state = {channel: channel, images: props.images, ref: null, loading: props.loading}
    this.state.channel.join()
  }

  componentDidMount () {
    const ref = this.state.channel.on('new_images', payload => {
      const newImages = this.state.images.concat(payload.images)
      this.setState({images: newImages, loading: false})
    })

    this.setState({ref: ref})
    this.setLoadingTimeout()
  }

  // If no new images are received within 5000 milliseconds
  setLoadingTimeout () {
    if (this.state.loading === true) {
      window.setTimeout(() => {
        this.setState({loading: false})
      }, 5000)
    }
  }

  componentWillUnmount () {
    this.state.chan.off('new_images', this.state.ref)
  }

  render () {
    const loader = this.state.loading === true ? <Loading /> : ''

    return (
      <div>
        {loader}
        <Grid id='masonry' images={this.state.images} />
      </div>
    )
  }
}

export default Images
