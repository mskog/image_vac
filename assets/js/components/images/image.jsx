import React from 'react'
import PropTypes from 'prop-types'

class Image extends React.Component {
  static propTypes = {
    url: PropTypes.string,
    thumbnail_width: PropTypes.number,
    thumbnail_height: PropTypes.number,
    thumbnail_url: PropTypes.string
  }

  render () {
    const divStyle = {
      width: this.props.thumbnail_width * 125 / this.props.thumbnail_height + 'px',
      'flexGrow': this.props.thumbnail_width * 200 / this.props.thumbnail_height
    }

    const iconStyle = {
      'paddingBottom': this.props.thumbnail_height / this.props.thumbnail_width * 100 + '%'
    }

    return (
      <div style={divStyle}>
        <a href={this.props.url} target='_blank'>
          <i style={iconStyle} />
          <img src={this.props.thumbnail_url} />
        </a>
      </div>
    )
  }
}

export default Image
