//@flow
import styled from 'styled-components'
import { Link } from 'react-router'
import { palette } from 'Theme'

export const HeightSeparator = styled.div`
  width: 100%;
  height: ${p => p.height}px;
`
export const InternalLink = styled(Link)`
  color: ${palette.primary};
  font-size: 16px;
`
export const ErrorContainer = styled(Link)`
  color: ${palette.red};
`
