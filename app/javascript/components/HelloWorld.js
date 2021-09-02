import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class HelloWorld extends React.Component {
  render () {
    return (
        <div>
        Name: {this.props.name}
        </div>
    );
  }
}

HelloWorld.propTypes = {
  name: PropTypes.string
};
export default HelloWorld
