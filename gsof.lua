-- Define DCOL Protocol
local dcol_proto = Proto("DCOL", "Trimble Data Collector Format (DCOL)")

-- Define GENOUT Protocol (subdissector for GSOF)
local genout_proto = Proto("GENOUT", "Trimble GENOUT Packet (40h)")

-- Define GSOF Protocol (subdissector for GENOUT messages)
local gsof_proto = Proto("GSOF", "Trimble General Serial Output Format (GSOF)")

-- DCOL Field Definitions
local dcol_fields = {
    stx = ProtoField.uint8("dcol.stx", "Start transmission", base.HEX),
    status = ProtoField.uint8("dcol.status", "Receiver status code", base.DEC),
    packet_type = ProtoField.uint8("dcol.packet_type", "Hexadecimal code assigned to the packet", base.HEX),
    length = ProtoField.uint8("dcol.length", "Payload Length", base.DEC),
    payload = ProtoField.bytes("dcol.payload", "Payload"),
    checksum = ProtoField.uint8("dcol.checksum", "Checksum", base.HEX),
    etx = ProtoField.uint8("dcol.etx", "End transmission", base.HEX)
}
dcol_proto.fields = dcol_fields

-- GENOUT Field Definitions
local genout_fields = {
    transmission_number = ProtoField.uint8("genout.transmission_number", "Transmission Number", base.DEC),
    page_index = ProtoField.uint8("genout.page_index", "Page Index", base.DEC),
    max_page_index = ProtoField.uint8("genout.max_page_index", "Max Page Index", base.DEC),
    gsof_data = ProtoField.bytes("genout.gsof_data", "GSOF Data")
}
genout_proto.fields = genout_fields

-- GSOF Field Definitions
local gsof_fields = {
    record_type = ProtoField.uint8("gsof.record_type", "Record Type", base.DEC),
    record_name = ProtoField.string("gsof.record_name", "Record Name"),
    record_length = ProtoField.uint8("gsof.record_length", "Record Length", base.DEC),
    record_data = ProtoField.bytes("gsof.record_data", "Record Data")
}
gsof_proto.fields = gsof_fields

-- GSOF 1 (pos time) Fields
local gsof_1_fields = {
    gps_time_ms = ProtoField.uint32("gsof.postime.gps_time_ms", "GPS Time (ms)", base.DEC),
    gps_week_number = ProtoField.uint16("gsof.postime.gps_week_number", "GPS Week Number", base.DEC),
    number_svs_used = ProtoField.uint8("gsof.postime.n_svs_used", "Number of satellites used to determine position", base.DEC),
}
gsof_proto.fields = gsof_1_fields

-- GSOF 49 (INS Full Navigation) Fields
local gsof_49_fields = {
    gps_week_number = ProtoField.uint16("gsof.ins.gps_week_number", "GPS Week Number", base.DEC),
    gps_time_ms = ProtoField.uint32("gsof.ins.gps_time_ms", "GPS Time (ms)", base.DEC),
    imu_alignment_status = ProtoField.uint8("gsof.ins.imu_alignment_status", "IMU Alignment Status", base.HEX),
    gps_quality_indicator = ProtoField.uint8("gsof.ins.gps_quality_indicator", "GPS Quality Indicator", base.HEX),
    latitude = ProtoField.double("gsof.ins.latitude", "Latitude (°)"),
    longitude = ProtoField.double("gsof.ins.longitude", "Longitude (°)"),
    altitude = ProtoField.double("gsof.ins.altitude", "Altitude (m)"),
    velocity_n = ProtoField.float("gsof.ins.velocity_n", "North Velocity (m/s)"),
    velocity_e = ProtoField.float("gsof.ins.velocity_e", "East Velocity (m/s)"),
    velocity_d = ProtoField.float("gsof.ins.velocity_d", "Down Velocity (m/s)"),
    total_speed = ProtoField.float("gsof.ins.total_speed", "Total Speed (m/s)"),
    roll = ProtoField.double("gsof.ins.roll", "Roll (°)"),
    pitch = ProtoField.double("gsof.ins.pitch", "Pitch (°)"),
    heading = ProtoField.double("gsof.ins.heading", "Heading (°)"),
    track_angle = ProtoField.double("gsof.ins.track_angle", "Track Angle (°)"),
    angular_rate_x = ProtoField.float("gsof.ins.angular_rate_x", "Angular Rate X (°/s)"),
    angular_rate_y = ProtoField.float("gsof.ins.angular_rate_y", "Angular Rate Y (°/s)"),
    angular_rate_z = ProtoField.float("gsof.ins.angular_rate_z", "Angular Rate Z (°/s)"),
    acceleration_x = ProtoField.float("gsof.ins.acceleration_x", "Longitudinal Acceleration X (m/s²)"),
    acceleration_y = ProtoField.float("gsof.ins.acceleration_y", "Transverse Acceleration Y (m/s²)"),
    acceleration_z = ProtoField.float("gsof.ins.acceleration_z", "Down Acceleration Z (m/s²)")
}
gsof_proto.fields = gsof_49_fields

-- GSOF 50 (INS RMS) Fields
local gsof_50_fields = {
    gps_week_number = ProtoField.uint16("gsof.ins_rms.gps_week_number", "GPS Week Number", base.DEC),
    gps_time_ms = ProtoField.uint32("gsof.ins_rms.gps_time_ms", "GPS Time (ms)", base.DEC),
    imu_alignment_status = ProtoField.uint8("gsof.ins_rms.imu_alignment_status", "IMU Alignment Status", base.HEX),
    gps_quality_indicator = ProtoField.uint8("gsof.ins_rms.gps_quality_indicator", "GPS Quality Indicator", base.HEX),
    north_pos_rms = ProtoField.float("gsof.ins_rms.north_pos_rms", "North Position RMS (m)"),
    east_pos_rms = ProtoField.float("gsof.ins_rms.east_pos_rms", "East Position RMS (m)"),
    down_pos_rms = ProtoField.float("gsof.ins_rms.down_pos_rms", "Down Position RMS (m)"),
    north_velocity_rms = ProtoField.float("gsof.ins_rms.north_velocity_rms", "North Velocity RMS (m)"),
    east_velocity_rms = ProtoField.float("gsof.ins_rms.east_velocity_rms", "East Velocity RMS (m)"),
    down_velocity_rms = ProtoField.float("gsof.ins_rms.down_velocity_rms", "Down Velocity RMS (m)"),
    roll_rms = ProtoField.float("gsof.ins_rms.roll_rms", "Roll RMS (m)"),
    pitch_rms = ProtoField.float("gsof.ins_rms.pitch_rms", "Pitch RMS (m)"),
    heading_rms = ProtoField.float("gsof.ins_rms.heading_rms", "Heading RMS (m)"),
}
gsof_proto.fields = gsof_50_fields


-- GSOF 70 (Lat, Long, MSL Height) Fields
local gsof_70_fields = {
    latitude = ProtoField.double("gsof.llh_msl.latitude", "Latitude (rad)"),
    longitude = ProtoField.double("gsof.llh_msl.longitude", "Longitude (rad)"),
    height = ProtoField.double("gsof.llh_msl.height", "Height (m) MSL"),
    model = ProtoField.string("gsof.llh_msl.model", "Character string with the geoid model name, this will typically be EGM96")
    -- TODO model
}
gsof_proto.fields = gsof_70_fields

-- GSOF Record Type Mapping Function
local function get_gsof_record_name(record_type)
    local record_types = {
        [1]  = "Position Time",
        [2]  = "Velocity",
        [3]  = "Altitude",
        [4]  = "DOPs",
        [5]  = "Clock Info",
        [6]  = "Position RMS",
        [7]  = "SV Brief",
        [8]  = "SV Detailed",
        [49] = "INS Full Navigation",
        [50] = "INS RMS",
        [70] = "Lat, Long, MSL Height",

    }
    return record_types[record_type] or "Unknown"
end

local function parse_gsof_1(tree, buffer, offset)
    tree:add(gsof_1_fields.gps_time_ms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_1_fields.gps_week_number, buffer(offset, 2))
    offset = offset + 2

    tree:add(gsof_1_fields.number_svs_used, buffer(offset, 1))
    offset = offset + 1
end

local function parse_gsof_49(tree, buffer, offset)
    tree:add(gsof_49_fields.gps_week_number, buffer(offset, 2))
    offset = offset + 2

    tree:add(gsof_49_fields.gps_time_ms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.imu_alignment_status, buffer(offset, 1))
    offset = offset + 1

    tree:add(gsof_49_fields.gps_quality_indicator, buffer(offset, 1))
    offset = offset + 1

    tree:add(gsof_49_fields.latitude, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.longitude, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.altitude, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.velocity_n, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.velocity_e, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.velocity_d, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.total_speed, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.roll, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.pitch, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.heading, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.track_angle, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_49_fields.angular_rate_x, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.angular_rate_y, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.angular_rate_z, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.acceleration_x, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.acceleration_y, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_49_fields.acceleration_z, buffer(offset, 4))
end

local function parse_gsof_50(tree, buffer, offset)
    tree:add(gsof_50_fields.gps_week_number, buffer(offset, 2))
    offset = offset + 2

    tree:add(gsof_50_fields.gps_time_ms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.imu_alignment_status, buffer(offset, 1))
    offset = offset + 1

    tree:add(gsof_50_fields.gps_quality_indicator, buffer(offset, 1))
    offset = offset + 1

    tree:add(gsof_50_fields.north_pos_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.east_pos_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.down_pos_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.north_velocity_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.east_velocity_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.down_velocity_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.roll_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.pitch_rms, buffer(offset, 4))
    offset = offset + 4

    tree:add(gsof_50_fields.heading_rms, buffer(offset, 4))
end

local function parse_gsof_70(tree, buffer, offset)
    local lat_rad = buffer(offset, 8):le_float() -- Extract as double (little-endian)
    local lat_deg = math.deg(lat_rad) -- Convert to degrees
    lat_item = tree:add(gsof_70_fields.latitude, buffer(offset, 8))
    lat_item:set_text("FOO")
    -- lat_item:set_text("Latitude: %.6f° (%.6f rad)", lat_deg, lat_rad))
    offset = offset + 8

    tree:add(gsof_70_fields.longitude, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_70_fields.height, buffer(offset, 8))
    offset = offset + 8

    tree:add(gsof_70_fields.model, buffer(offset))
end

local function parse_gsof(record_tree, record_type, buffer, offset, record_length)
    local tree = record_tree:add(gsof_proto, buffer(offset + 2, record_length), get_gsof_record_name(record_type) .. " Data")
    offset = offset + 2  -- Skip record_type and record_length

    if record_type == 1 then
        parse_gsof_1(tree, buffer, offset)
    elseif record_type == 49 then
        parse_gsof_49(tree, buffer, offset)
    elseif record_type == 50 then
        parse_gsof_50(tree, buffer, offset)
    elseif record_type == 70 then
        parse_gsof_70(tree, buffer, offset)
    end
end

-- GSOF Subdissector Function
function gsof_proto.dissector(buffer, pinfo, tree)
    pinfo.cols.protocol = gsof_proto.name
    local offset = 0
    local gsof_tree = tree:add(gsof_proto, buffer(), "GSOF Records")

    while offset < buffer:len() do
        if offset + 2 > buffer:len() then break end  

        local record_type = buffer(offset, 1):uint()
        local record_length = buffer(offset + 1, 1):uint()
        local record_name = string.format("Record Type %d - %s", record_type, get_gsof_record_name(record_type))

        if offset + 2 + record_length > buffer:len() then
            gsof_tree:add_expert_info(PI_MALFORMED, PI_ERROR, "Truncated GSOF Record")
            break
        end

        local record_tree = gsof_tree:add(gsof_proto, buffer(offset, 2 + record_length), record_name)
        
        record_tree:add(gsof_fields.record_type, buffer(offset, 1))
        record_tree:add(gsof_fields.record_length, buffer(offset + 1, 1))

        parse_gsof(record_tree, record_type, buffer, offset, record_length)

        offset = offset + 2 + record_length
    end
end

-- DCOL Dissector Function
function dcol_proto.dissector(buffer, pinfo, tree)
    pinfo.cols.protocol = dcol_proto.name
    local offset = 0
    local udp_length = buffer:len()

    while offset < udp_length do
        if offset + 6 > udp_length then 
            tree:add_expert_info(PI_MALFORMED, PI_ERROR, "Truncated DCOL packet")
            break 
        end

        -- Ensure STX is present
        if buffer(offset, 1):uint() ~= 0x02 then
            tree:add_expert_info(PI_MALFORMED, PI_WARN, "Expected STX (0x02) but not found")
            break
        end

        local start_offset = offset

        -- Read packet header fields
        local stx = buffer(offset, 1)
        local status = buffer(offset + 1, 1)
        local packet_type = buffer(offset + 2, 1):uint()
        local payload_length = buffer(offset + 3, 1):uint()

        -- Calculate total packet size
        local packet_size = payload_length + 6  -- STX + status + type + length + checksum + ETX

        -- Ensure we don't read beyond the buffer
        if offset + packet_size > udp_length then
            tree:add_expert_info(PI_MALFORMED, PI_ERROR, "Packet length exceeds available data")
            break
        end

        -- **🔹 Create the subtree only for the current packet range**
        local subtree = tree:add(dcol_proto, buffer(offset, packet_size), "DCOL Packet")

        subtree:add(dcol_fields.stx, stx)
        subtree:add(dcol_fields.status, status)
        subtree:add(dcol_fields.packet_type, buffer(offset + 2, 1))
        subtree:add(dcol_fields.length, buffer(offset + 3, 1))

        offset = offset + 4  -- Move past header fields

        -- Process GENOUT packets
        if packet_type == 0x40 then
            local genout_tvb = buffer(offset, payload_length):tvb()
            local genout_tree = subtree:add(genout_proto, genout_tvb, "GENOUT Packet")
            genout_proto.dissector(genout_tvb, pinfo, genout_tree)
        else
            subtree:add(dcol_fields.payload, buffer(offset, payload_length))
        end

        offset = offset + payload_length

        -- Ensure there's enough data for checksum + ETX
        if offset + 2 > udp_length then 
            subtree:add_expert_info(PI_MALFORMED, PI_ERROR, "Missing checksum or ETX")
            break 
        end

        -- Add checksum
        subtree:add(dcol_fields.checksum, buffer(offset, 1))
        offset = offset + 1

        -- Ensure ETX (0x03)
        if buffer(offset, 1):uint() ~= 0x03 then
            subtree:add_expert_info(PI_MALFORMED, PI_ERROR, "Missing ETX (0x03)")
            break
        end
        subtree:add(dcol_fields.etx, buffer(offset, 1))
        offset = offset + 1

        -- Ensure progress
        if offset == start_offset then break end
    end

end

-- GENOUT Dissector Function
function genout_proto.dissector(buffer, pinfo, tree)
    if buffer:len() < 7 then return end  

    pinfo.cols.protocol = genout_proto.name
    local subtree = tree:add(genout_proto, buffer(), "GENOUT Packet")

    local offset = 0
    subtree:add(genout_fields.transmission_number, buffer(offset, 1))
    offset = offset + 1

    subtree:add(genout_fields.page_index, buffer(offset, 1))
    offset = offset + 1

    subtree:add(genout_fields.max_page_index, buffer(offset, 1))
    offset = offset + 1

    -- Remaining is GSOF Data
    if buffer:len() > offset then
        local gsof_tvb = buffer(offset)
        local gsof_tree = subtree:add(genout_fields.gsof_data, gsof_tvb)

        -- Call GSOF Parser TODO
        gsof_proto.dissector(gsof_tvb:tvb(), pinfo, gsof_tree)
    end
end

-- Register DCOL on UDP Port 44444
DissectorTable.get("udp.port"):add(44444, dcol_proto)
